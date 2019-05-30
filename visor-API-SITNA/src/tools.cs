using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace visor2018
{
    public static class tools
    {
        public static int[] ProcesarBOX(string box)
        {
            string[] tmp = box.Substring(4, box.Length - 5).Split(", ".ToCharArray());
            if (tmp.Length == 4)
            {
                int[] ret = new int[4];
                for (int i = 0; i < ret.Length; i++)
                {
                    ret[i] = Convert.ToInt32(Math.Round(Convert.ToDouble(tmp[i], CultureInfo.InvariantCulture)));
                }
                return ret;
            }
            else
            {
                return new int[0];
            }
        }
    }
}