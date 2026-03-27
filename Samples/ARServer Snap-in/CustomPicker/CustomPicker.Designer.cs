namespace CustomPicker
{
    partial class CustomPicker
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CustomPicker));
            this.buttonOK = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.labelParameter = new System.Windows.Forms.Label();
            this.textBoxParameterName = new System.Windows.Forms.TextBox();
            this.labelValue = new System.Windows.Forms.Label();
            this.textBoxParameterValue = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.m_rbObject = new System.Windows.Forms.RadioButton();
            this.m_rbContainer = new System.Windows.Forms.RadioButton();
            this.m_rbNoValue = new System.Windows.Forms.RadioButton();
            this.m_btnAdd = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // buttonOK
            // 
            this.buttonOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonOK.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.buttonOK.Location = new System.Drawing.Point(414, 215);
            this.buttonOK.Name = "buttonOK";
            this.buttonOK.Size = new System.Drawing.Size(75, 23);
            this.buttonOK.TabIndex = 1;
            this.buttonOK.Text = "OK";
            this.buttonOK.UseVisualStyleBackColor = true;
            this.buttonOK.Click += new System.EventHandler(this.buttonOK_Click);
            // 
            // button1
            // 
            this.button1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.button1.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.button1.Location = new System.Drawing.Point(503, 215);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "Cancel";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // labelParameter
            // 
            this.labelParameter.AutoSize = true;
            this.labelParameter.Location = new System.Drawing.Point(12, 14);
            this.labelParameter.Name = "labelParameter";
            this.labelParameter.Size = new System.Drawing.Size(38, 13);
            this.labelParameter.TabIndex = 2;
            this.labelParameter.Text = "Name:";
            // 
            // textBoxParameterName
            // 
            this.textBoxParameterName.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.textBoxParameterName.Location = new System.Drawing.Point(71, 11);
            this.textBoxParameterName.Name = "textBoxParameterName";
            this.textBoxParameterName.ReadOnly = true;
            this.textBoxParameterName.Size = new System.Drawing.Size(507, 20);
            this.textBoxParameterName.TabIndex = 3;
            // 
            // labelValue
            // 
            this.labelValue.AutoSize = true;
            this.labelValue.Location = new System.Drawing.Point(12, 48);
            this.labelValue.Name = "labelValue";
            this.labelValue.Size = new System.Drawing.Size(37, 13);
            this.labelValue.TabIndex = 2;
            this.labelValue.Text = "Value:";
            // 
            // textBoxParameterValue
            // 
            this.textBoxParameterValue.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.textBoxParameterValue.Location = new System.Drawing.Point(72, 45);
            this.textBoxParameterValue.Name = "textBoxParameterValue";
            this.textBoxParameterValue.ReadOnly = true;
            this.textBoxParameterValue.Size = new System.Drawing.Size(506, 20);
            this.textBoxParameterValue.TabIndex = 3;
            // 
            // groupBox1
            // 
            this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox1.Controls.Add(this.m_rbObject);
            this.groupBox1.Controls.Add(this.m_rbContainer);
            this.groupBox1.Controls.Add(this.m_rbNoValue);
            this.groupBox1.Location = new System.Drawing.Point(72, 79);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(417, 103);
            this.groupBox1.TabIndex = 10;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Select Value Type";
            // 
            // m_rbObject
            // 
            this.m_rbObject.AutoSize = true;
            this.m_rbObject.Location = new System.Drawing.Point(14, 71);
            this.m_rbObject.Name = "m_rbObject";
            this.m_rbObject.Size = new System.Drawing.Size(80, 17);
            this.m_rbObject.TabIndex = 12;
            this.m_rbObject.Text = "Leaf Object";
            this.m_rbObject.UseVisualStyleBackColor = true;
            // 
            // m_rbContainer
            // 
            this.m_rbContainer.AutoSize = true;
            this.m_rbContainer.Location = new System.Drawing.Point(14, 47);
            this.m_rbContainer.Name = "m_rbContainer";
            this.m_rbContainer.Size = new System.Drawing.Size(104, 17);
            this.m_rbContainer.TabIndex = 11;
            this.m_rbContainer.Text = "Container Object";
            this.m_rbContainer.UseVisualStyleBackColor = true;
            // 
            // m_rbNoValue
            // 
            this.m_rbNoValue.AutoSize = true;
            this.m_rbNoValue.Checked = true;
            this.m_rbNoValue.Location = new System.Drawing.Point(14, 23);
            this.m_rbNoValue.Name = "m_rbNoValue";
            this.m_rbNoValue.Size = new System.Drawing.Size(54, 17);
            this.m_rbNoValue.TabIndex = 10;
            this.m_rbNoValue.TabStop = true;
            this.m_rbNoValue.Text = "Empty";
            this.m_rbNoValue.UseVisualStyleBackColor = true;
            this.m_rbNoValue.CheckedChanged += new System.EventHandler(this.m_rbNoValue_CheckedChanged);
            // 
            // m_btnAdd
            // 
            this.m_btnAdd.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.m_btnAdd.Location = new System.Drawing.Point(503, 159);
            this.m_btnAdd.Name = "m_btnAdd";
            this.m_btnAdd.Size = new System.Drawing.Size(75, 23);
            this.m_btnAdd.TabIndex = 11;
            this.m_btnAdd.Text = "Select";
            this.m_btnAdd.UseVisualStyleBackColor = true;
            this.m_btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox2.Location = new System.Drawing.Point(11, 196);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(567, 3);
            this.groupBox2.TabIndex = 12;
            this.groupBox2.TabStop = false;
            // 
            // CustomPicker
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(592, 253);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.m_btnAdd);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.textBoxParameterValue);
            this.Controls.Add(this.labelValue);
            this.Controls.Add(this.textBoxParameterName);
            this.Controls.Add(this.labelParameter);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.buttonOK);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximumSize = new System.Drawing.Size(1000, 280);
            this.MinimumSize = new System.Drawing.Size(300, 280);
            this.Name = "CustomPicker";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
            this.Text = "Edit Parameter";
            this.Load += new System.EventHandler(this.CustomPicker_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonOK;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label labelParameter;
        private System.Windows.Forms.TextBox textBoxParameterName;
        private System.Windows.Forms.Label labelValue;
        private System.Windows.Forms.TextBox textBoxParameterValue;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton m_rbObject;
        private System.Windows.Forms.RadioButton m_rbContainer;
        private System.Windows.Forms.RadioButton m_rbNoValue;
        private System.Windows.Forms.Button m_btnAdd;
        private System.Windows.Forms.GroupBox groupBox2;
    }
}

