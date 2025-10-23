using System;
using System.Collections.Generic;
using System.Linq;
using Models;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IDuAnRepository
    {
        DuAn GetDuAnbyID(string id);
        bool Create(DuAn duan);
        bool Update(DuAn duan);
        bool Delete(string id);
        List<DuAn> Search(int pageIndex, int pageSize, out long total, string Tenduan, string Maduan);
    }
}
