using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;
using DAL.Helper;
using DAL.Helper.Interfaces;
using DAL.Interfaces;

namespace DAL
{
    public partial class DuAnRepository : IDuAnRepository
    {
        private IDatabaseHelper _dbHelper;

        public DuAnRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public bool Create(DuAn duan)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_duan_create",
                    "@Maduan", duan.Maduan,
                    "@Tenduan", duan.Tenduan,
                    "@Motada", duan.Motada,
                    "@Ngaybatdau", duan.Ngaybatdau,
                    "@Ngayketthuc", duan.Ngayketthuc,
                    "@Trangthai", duan.Trangthai,
                    "@Nguoitao", duan.Nguoitao);

                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool Delete(string id)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_duan_delete",
                "@Maduan", id);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(DuAn duan)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_duan_update",
                   "@Maduan", duan.Maduan,
                   "@Tenduan", duan.Tenduan,
                   "@Motada", duan.Motada,
                   "@Ngaybatdau", duan.Ngaybatdau,
                   "@Ngayketthuc", duan.Ngayketthuc,
                   "@Trangthai", duan.Trangthai,
                   "@Nguoitao", duan.Nguoitao);

                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public DuAn GetDuAnbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_duan_get_by_id",
                     "@Maduan", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<DuAn>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<DuAn> Search(int pageIndex, int pageSize, out long total, string Tenduan, string Maduan)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_duan_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@Tenduan", Tenduan,
                    "@Maduan", Maduan);

                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                if (dt.Rows.Count > 0 && dt.Rows[0]["RecordCount"] != DBNull.Value)
                    total = Convert.ToInt64(dt.Rows[0]["RecordCount"]);

                return dt.ConvertTo<DuAn>().ToList();
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi tìm kiếm dự án: " + ex.Message);
            }
        }

    }
}


