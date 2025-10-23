using DAL;
using Microsoft.IdentityModel.Tokens;
using Models;
using System;
using Helper;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using BLL.Interfaces;
using DAL.Interfaces;



namespace BLL
{
    public partial class Duan_BLL : IDuan_BLL
    {
        private IDuAnRepository _res;
        
        public Duan_BLL (IDuAnRepository res)
        {
            _res = res;
        }

        public bool Create (DuAn duan)
        {
            return _res.Create (duan);
        }

        public bool Update(DuAn duan)
        {
            return _res.Update(duan);
        }

        public bool Delete(string id)
        {
            return _res.Delete(id);
        }

        public DuAn GetDuAnbyID(string id)
        {
            return _res.GetDuAnbyID(id);
        }

        public List<DuAn> Search(int pageIndex, int pageSize, out long total, string Tenduan, string Maduan)
        {
            return _res.Search(pageIndex, pageSize,out total, Tenduan, Maduan);
        }
    }
}
