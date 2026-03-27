using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace CustomPicker
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            CustomPickerObj pck = new CustomPickerObj();
            object obj = (object)new string[1];
            long lRet = pck.ShowPicker(null, 0, "test", true, null, "ServerName", null, null);
        }
    }
}
