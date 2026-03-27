//--------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Interop.ActiveDs;
using Web.Interfaces;

namespace CustomDevelopment
{
    /// <summary>
    /// This class is used for test purposes only
    /// Don't remove it from the project
    /// </summary>
    public class SimpleCustomCommand : ICustomCommand
    {
        private IADs m_currentAdObject;
        private Control m_Container;
        private IDictionary<string, string> m_CommandSettings;
        private IDictionary<string, string> m_RuntimeVariables;
        private TextBox m_GivenNameBox = new TextBox();
        private TextBox m_InitialsBox = new TextBox();

        private void Init(IADs adsObject, Control container, IDictionary<string, string> commandSettings,
                          IDictionary<string, string> runtimeVariables)
        {
            if (m_currentAdObject == null)
            {
                m_currentAdObject = adsObject;
            }

            if (m_Container == null)
            {
                m_Container = container;
            }

            if (m_CommandSettings == null)
            {
                m_CommandSettings = commandSettings;
            }

            if (m_RuntimeVariables == null)
            {
                m_RuntimeVariables = runtimeVariables;
            }
        }

        public void Get(IADs adsObject, Control container, IDictionary<string, string> commandSettings,
                        IDictionary<string, string> runtimeVariables)
        {
            Init(adsObject, container, commandSettings, runtimeVariables);
            container.Controls.Add(GetHeader());
            container.Controls.Add(GetADObjectPropertiesTable());
            container.Controls.Add(
                GetTableForStringDictionary("The command contains following settings:", m_CommandSettings));
            container.Controls.Add(
                GetTableForStringDictionary("The command resolves following RintimeVariables:", m_CommandSettings));
            container.Controls.Add(GetTableForAttributesChange());
        }

        private Control GetHeader()
        {
            HtmlGenericControl result = new HtmlGenericControl("h5");
            Literal headerText = new Literal();
            headerText.Text =
                String.Format("This UI was generated with custom command in managed code and applied for {0} class.",
                              m_currentAdObject.Class);
            result.Controls.Add(headerText);
            return result;
        }

        private static Table GetTableForStringDictionary(String tableHeader, IDictionary<string, string> dictionary)
        {
            Literal headerText = new Literal();
            headerText.Text = tableHeader;
            TableHeaderCell headerCell = new TableHeaderCell();
            headerCell.BackColor = Color.Gainsboro;
            headerCell.Controls.Add(headerText);

            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.Cells.Add(headerCell);

            Table table = new Table();
            table.CellPadding = 3;
            table.BorderStyle = BorderStyle.Dotted;
            table.BorderWidth = 1;
            table.Style["margin-top"] = "20px";
            table.Width = Unit.Parse("100%");
            table.Rows.Add(headerRow);

            foreach (KeyValuePair<string, string> pair in dictionary)
            {
                table.Rows.Add(GetRowForDictionaryPair(pair));
            }

            return table;
        }

        private static TableRow GetRowForDictionaryPair(KeyValuePair<string, string> pair)
        {
            Literal literal = new Literal();
            literal.Text = String.Format("{0}: {1}", pair.Key, pair.Value);
            TableCell cell = new TableCell();
            cell.Controls.Add(literal);
            TableRow result = new TableRow();
            result.Cells.Add(cell);
            return result;
        }

        private Table GetADObjectPropertiesTable()
        {
            Literal headerText = new Literal();
            headerText.Text = "Values of attributes for input IADs.";

            TableHeaderCell headerCell = new TableHeaderCell();
            headerCell.BackColor = Color.Gainsboro;
            headerCell.Controls.Add(headerText);

            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.Cells.Add(headerCell);

            Table table = new Table();
            table.CellPadding = 3;
            table.BorderStyle = BorderStyle.Dotted;
            table.BorderWidth = 1;
            table.Width = Unit.Parse("100%");
            table.Rows.Add(headerRow);

            table.Rows.Add(GetTableRowFor("name"));
            table.Rows.Add(GetTableRowFor("displayName"));
            table.Rows.Add(GetTableRowFor("distinguishedName"));
            table.Rows.Add(GetTableRowFor("userPrincipalName"));

            return table;
        }

        private TableRow GetTableRowFor(String propertyName)
        {
            String propertyValue = m_currentAdObject.Get(propertyName) as String;
            Literal literal = new Literal();
            literal.Text = String.Format("{0} is: {1}", propertyName, propertyValue);

            TableCell cell = new TableCell();
            cell.Controls.Add(literal);
            TableRow result = new TableRow();
            result.Cells.Add(cell);
            return result;
        }

        private Table GetTableForAttributesChange()
        {
            Literal headerText = new Literal();
            headerText.Text = "Type in new values for attributes and try to change ones.";

            TableHeaderCell headerCell = new TableHeaderCell();
            headerCell.BackColor = Color.Gainsboro;
            headerCell.Controls.Add(headerText);
            headerCell.ColumnSpan = 2;

            TableHeaderRow headerRow = new TableHeaderRow();
            headerRow.Cells.Add(headerCell);

            Table table = new Table();
            table.CellPadding = 3;
            table.BorderStyle = BorderStyle.Dotted;
            table.BorderWidth = 1;
            table.Style["margin-top"] = "20px";
            table.Width = Unit.Parse("100%");
            table.Rows.Add(headerRow);

            table.Rows.Add(GetEditableRowFor("givenName", m_GivenNameBox));
            table.Rows.Add(GetEditableRowFor("initials", m_InitialsBox));

            HtmlInputButton submitButton = new HtmlInputButton("submit");
            submitButton.Attributes["value"] = "Apply changes";
            TableCell cell = new TableCell();
            cell.ColumnSpan = 2;
            cell.Style["text-align"] = "center";
            cell.Controls.Add(submitButton);
            TableRow row = new TableRow();
            row.Cells.Add(cell);
            table.Rows.Add(row);

            return table;
        }

        private TableRow GetEditableRowFor(String propertyName, TextBox valueBox)
        {
            TableCell cell1 = new TableCell();
            cell1.Style["text-align"] = "right";
            Label label = new Label();
            label.Text = propertyName + ": ";
            cell1.Controls.Add(label);

            TableCell cell2 = new TableCell();
            cell2.Width = Unit.Parse("100%");
            valueBox.ID = propertyName;
            if (!m_Container.Page.IsPostBack)
            {
                String propertyValue = m_currentAdObject.Get(propertyName) as String;
                valueBox.Text = propertyValue;
            }
            cell2.Controls.Add(valueBox);

            TableRow result = new TableRow();
            result.Cells.Add(cell1);
            result.Cells.Add(cell2);
            return result;
        }

        public void Set(IADs adsObject, Control container, IDictionary<string, string> commandSettings,
                        IDictionary<string, string> runtimeVariables)
        {
            Init(adsObject, container, commandSettings, runtimeVariables);
            container.Page.LoadComplete += new EventHandler(Page_LoadComplete);
        }

        private void Page_LoadComplete(object sender, EventArgs e)
        {
            m_currentAdObject.Put("givenName", m_GivenNameBox.Text);
            m_currentAdObject.Put("initials", m_InitialsBox.Text);
            m_currentAdObject.SetInfo();
        }
    }
}
