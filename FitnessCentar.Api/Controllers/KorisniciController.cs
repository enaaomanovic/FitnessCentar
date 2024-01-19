using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Authentication;
//using FitnessCentar.Model;
namespace FitnessCentar.Controllers
{
    [ApiController]

    public class KorisniciController : BaseController<Model.Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        private readonly IKorisniciService _korisniciService;
        public KorisniciController(ILogger<BaseController<Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>> logger, IKorisniciService service) : base(logger, service)
        {
            _korisniciService = service;
        }


        [HttpPost("{userId}/change-password")]
        public async Task<IActionResult> ChangePassword(int userId, [FromBody] KorisniciChangePassword changePasswordModel)
        {
            try
            {
                // Ensure that the user making the request is changing their own password
                if (userId != changePasswordModel.Id)
                {
                    return Forbid("You don't have permission to change this user's password.");
                }

                // Your authentication logic here (e.g., check if the user making the request is authenticated)

                await _korisniciService.ChangePasswordAsync(changePasswordModel);

                return Ok(new { Message = "Password changed successfully." }); // 200 OK with a success message
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message); // 500 Internal Server Error
            }
        }

        [HttpPost("{userId}/change-username")]
        public async Task<IActionResult> ChangeUsername(int userId, [FromBody] KorisniciChangeUsername changeUsernameModel)
        {
            try
            {
                // Ensure that the user making the request is changing their own username
                if (userId != changeUsernameModel.Id)
                {
                    return Forbid("You don't have permission to change this user's username.");
                }

                // Your authentication logic here (e.g., check if the user making the request is authenticated)

                await _korisniciService.ChangeUsernameAsync(changeUsernameModel);

                return Ok(new { Message = "Username changed successfully." }); // 200 OK with a success message
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message); // 500 Internal Server Error
            }
        }




    }

}
