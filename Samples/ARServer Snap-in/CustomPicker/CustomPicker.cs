using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.DirectoryServices;
using Interop.ArsAppCntxtMenuCommand;

//
using Interop.ArsSnapComponents;




namespace CustomPicker
{
    public partial class CustomPicker : Form
    {
        //Map that stores all parameters and their values
        private System.Collections.Generic.Dictionary<string, string> m_mapAllParameters = new Dictionary<string, string>();

        //The list of values for current parameter
        private System.Collections.Generic.List<string> m_lstValues = new List<string>();

        //Parameter name
        private string m_strParameterName = "";

        //Parameter value
        private string m_strParameterValue = "";

        //Context
        private Interop.ArsSnapComponents.IEDMSnapContextProvider m_Context = null;

        public CustomPicker(Interop.ArsSnapComponents.IEDMSnapContextProvider Context)
        {
            m_Context = Context;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }

        private void buttonOK_Click(object sender, EventArgs e)
        {
            ParameterValue = textBoxParameterValue.Text;

            DialogResult = DialogResult.OK;
            Close();
        }

        public void AddParam(string strName, string strValue)
        {
            m_mapAllParameters[strName] = strValue;
        }

        public void AddValue(string strValue)
        {
            m_lstValues.Add(strValue);
        }

        public string ParameterName { set { m_strParameterName = value; } }
        public string ParameterValue { set { m_strParameterValue = value; } get { return m_strParameterValue; } }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (m_rbContainer.Checked)
            {
                EDMSnapSelectContainerDialog dlg = m_Context.GetSelectContainerDialog();
                dlg.Caption = "Select Container";
                dlg.DisplayRoot = true;
                dlg.Label = "Select a container or create a new container.";
                dlg.SetStartScope(EDMSelectContainerStartScopeEnum.edmsnapSelectContainerEDMActiveDirectory);

                int nRes = dlg.Show((int)Handle);
                if (nRes == 1)
                {
                    m_strParameterValue = dlg.DN;
                    textBoxParameterValue.Text = m_strParameterValue;
                }
            }
            else if (m_rbObject.Checked)
            {
                bool bIsMultiSelect = false; //Use Multi or Single select object dialog
                string Filter = "(objectCategory=group)"; //LDAP filter for search of objects
                bool bShowWellKnownObjects = false; //Show WellKnown objects
                bool bUseReverseLookup = true; //Use Reverse lookup for typein

                Interop.ArsSnapComponents.IEDMSnapSelectObjectDialog selectedObjectDialog = m_Context.GetSelectObjectDialog(bIsMultiSelect);

                Interop.ArsSnapComponents.IEDMSnapSelectObjectDriverFactory selectObjectDriverFactory = m_Context.GetSelectObjectDriverFactory();

                if ((selectedObjectDialog != null) && (selectObjectDriverFactory != null))
                {
                    selectedObjectDialog.SelectObjectDriver = selectObjectDriverFactory.GetDriver(Filter, String.Empty);
                    selectedObjectDialog.SelectObjectDriver.UseWellknowns = bShowWellKnownObjects;
                    selectedObjectDialog.SelectObjectDriver.UseReverseLookup = bUseReverseLookup;
                    int res = selectedObjectDialog.Show((int)Handle);
                    if ((res == 1) && (selectedObjectDialog.SelectedObjects.Count > 0))
                    {
                        m_strParameterValue = "";
                        foreach (Interop.ArsSnapComponents.IEDMSnapSelectedObject group in selectedObjectDialog.SelectedObjects)
                        {
                            m_strParameterValue += group.DN + ";";
                        }
                        m_strParameterValue = m_strParameterValue.TrimEnd(';');
                        textBoxParameterValue.Text = m_strParameterValue;
                    }
                }
            }
            else
            {
                m_strParameterValue = "";
                textBoxParameterValue.Text = m_strParameterValue;
            }
        }

        private void m_rbNoValue_CheckedChanged(object sender, EventArgs e)
        {
            if (m_rbNoValue.Checked)
            {
                m_strParameterValue = "";
                textBoxParameterValue.Text = m_strParameterValue;
            }
        }

        private void CustomPicker_Load(object sender, EventArgs e)
        {
            textBoxParameterName.Text = m_strParameterName;
            m_strParameterValue = "";
            string strPath = "";
            foreach (string s in m_lstValues)
            {
                m_strParameterValue += s + ";";
                if (strPath == "")
                    strPath = s;
            }
            if (!string.IsNullOrEmpty(m_strParameterName))
            {
                string strSchemaClassName = GetSchemaClassName(strPath);
                m_rbObject.Checked = ("group" == strSchemaClassName);
                m_rbContainer.Checked = !m_rbObject.Checked;
            }
            m_strParameterValue = m_strParameterValue.TrimEnd(';');
            textBoxParameterValue.Text = m_strParameterValue;
        }

        private static string GetSchemaClassName(string strPath)
        {
            try
            {
                const AuthenticationTypes ADS_EDMSERVER_BIND = (AuthenticationTypes)32678;
                DirectoryEntry deEntry = new DirectoryEntry(string.Format("EDMS://{0}", strPath), null, null, ADS_EDMSERVER_BIND);
                return deEntry.SchemaClassName;
            }
            catch
            {
            }
            return "";
        }
    }

    public class CustomPickerObj : IARSCustomPicker
    {
        public int ShowPicker(Interop.ArsSnapComponents.IEDMSnapContextProvider pContextProvider, int ParentHWND, string SolutionID, bool IsReadOnlyMode, Interop.ArsSnapComponents.IEDMScriptParametersCollection pParametersCollection, string ParameterName, Interop.ArsSnapComponents.EDMSnapStringCollection pParameterValues, Interop.ArsSnapComponents.EDMSnapStringCollection pParameterOutValues)
        {
            CustomPicker CustomPicker = new CustomPicker(pContextProvider);
            CustomPicker.ParameterName = ParameterName;

            //
            Interop.ArsSnapComponents.IEDMSnapContextProvider _pContextProvider = pContextProvider;

            int _ParentHWND = ParentHWND;
            string _SolutionID = SolutionID;
            bool _IsReadOnlyMode = IsReadOnlyMode;

            foreach (string s in pParameterValues)
            {
                CustomPicker.AddValue(s);
            }

            //all parameters with current values
            foreach (Interop.ArsSnapComponents.IEDMScriptParameter param in pParametersCollection)
            {
                //The singlevalued parameter
                CustomPicker.AddParam(param.Name, param.Value);

                //The multivalued parameter
                foreach (string z in param.Values)
                {

                }
            }

            DialogResult res = CustomPicker.ShowDialog(new Win32Window(ParentHWND));
            //Return parameter value(s) to ARS snap-in
            pParameterOutValues.Clear();
            //Exmaple for multi-valued parameter
            List<string> lstValues = new List<string>(CustomPicker.ParameterValue.Split(';'));
            foreach (string strValue in lstValues)
            {
                pParameterOutValues.Add(strValue);
            }

            //Release references for quick memory clearing
            System.Runtime.InteropServices.Marshal.ReleaseComObject(pParameterValues);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(pParameterOutValues);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(pParametersCollection);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(pContextProvider);
            //ParametersCollection
            //
            return (int)res;
        }
    }


    //#region Private Class For IWin32Window
    public class Win32Window : IWin32Window
    {
        private int handle;

        public Win32Window(int argHandle)
        {
            this.handle = argHandle;
        }

        public System.IntPtr Handle
        {
            get { return new System.IntPtr(this.handle); }
        }
    }
    //  #endregion


}
