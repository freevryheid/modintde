module modintde
  use iso_fortran_env, only: dp=>real64
  implicit none
  private
  public :: intde, intdei, intdeo
  abstract interface
    function func(x) result(r)
      import dp
      real(dp), intent(in) :: x
      real(dp) :: r
    end function func
  end interface
  interface
    subroutine intde(f, a, b, eps, i, err)
      import dp
      procedure(func) :: f
      real(dp) :: a,b,eps,i,err
    end subroutine intde
    subroutine intdei(f, a, eps, i, err)
      import dp
      procedure(func) :: f
      real(dp) :: a,eps,i,err
    end subroutine intdei
    subroutine intdeo(f, a, omega, eps, i, err)
      import dp
      procedure(func) :: f
      real(dp) :: a,omega,eps,i,err
    end procedure intdeo
  end interface
end module modintde
