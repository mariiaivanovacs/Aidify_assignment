namespace Aidify_assigment
{
    public class InstructorBasePage : BaseRolePage
    {
        protected override string RequiredRole => Constants.RoleInstructor;

        protected int InstructorUserId
        {
            get { return AuthHelper.GetUserId(); }
        }
    }
}
