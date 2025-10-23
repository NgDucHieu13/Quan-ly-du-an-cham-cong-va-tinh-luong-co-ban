using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface IDuan_BLL
    {
        DuAn GetDuAnbyID(string id);
        bool Create(DuAn duan);
        bool Update(DuAn duan);
        bool Delete(string id);
        List<DuAn> Search(int pageIndex, int pageSize, out long total, string Tenduan, string Maduan);
    }
}
