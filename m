From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 3 May 2017 12:45:28 -0700
Subject: [PATCH v4 1/2] tiocsti-restrict : Add owner user namespace to
	tty_struct
In-Reply-To: <CAGXu5jLFkDB31W7uje3LaEujDrnvndQX9JK_hs47nc2dpbyNtQ@mail.gmail.com>
References: <20170424051512.20420-1-matt@nmatt.com>
	<20170424051512.20420-2-matt@nmatt.com>
	<20170424135751.GA9030@mail.hallyn.com>
	<CAGXu5jLFkDB31W7uje3LaEujDrnvndQX9JK_hs47nc2dpbyNtQ@mail.gmail.com>
Message-ID: <20170503194528.GA28882@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 03, 2017 at 12:32:07PM -0700, Kees Cook wrote:
> On Mon, Apr 24, 2017 at 6:57 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Quoting Matt Brown (matt at nmatt.com):
> >> This patch adds struct user_namespace *owner_user_ns to the tty_struct.
> >> Then it is set to current_user_ns() in the alloc_tty_struct function.
> >>
> >> This is done to facilitate capability checks against the original user
> >> namespace that allocated the tty.
> >>
> >> E.g. ns_capable(tty->owner_user_ns,CAP_SYS_ADMIN)
> >>
> >> This combined with the use of user namespace's will allow hardening
> >> protections to be built to mitigate container escapes that utilize TTY
> >> ioctls such as TIOCSTI.
> >>
> >> See: https://bugzilla.redhat.com/show_bug.cgi?id=1411256
> >>
> >> Signed-off-by: Matt Brown <matt@nmatt.com>
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> This Ack didn't end up in the v5, but I think it stands, yes?
> 
> Greg, is the v5 okay to pull for you or would a v6 with Acks/Reviews
> included be preferred?

v6 would be great, and we are dropping patch 2 from the series, right?
I was expecting this to be resent.  I'll start looking at new patches
like this after 4.12-rc1 is out.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
