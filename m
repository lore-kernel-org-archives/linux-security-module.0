From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Jul 2017 09:06:29 -0700
Subject: [PATCH v2 2/8] exec: Move security_bprm_secureexec() earlier
In-Reply-To: <87a84cr7oc.fsf@xmission.com>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
	<1499673451-66160-3-git-send-email-keescook@chromium.org>
	<87a84cr7oc.fsf@xmission.com>
Message-ID: <CAGXu5jLw6SsXM66x7ZHdj+Pb8Aepq7rHn1saNHRhq-wqk8p=4g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 10, 2017 at 1:57 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> There are several places where exec needs to know if a privilege-gain has
>> happened. These should be using the results of security_bprm_secureexec()
>> but it is getting (needlessly) called very late.
>
> It is hard to tell at a glance but I believe this introduces a
> regression.
>
> cap_bprm_set_creds is currently called before cap_bprm_secureexec and
> it has a number of cases such as no_new_privs and ptrace that can result
> in some of the precomputed credential changes not happening.
>
> Without accounting for that I believe your cap_bprm_securexec now
> returns a postive value too early.

It's still before cap_bprm_secureexec. cap_brpm_set_creds() is in
prepare_binprm(), which is well before exec_binprm() and it's eventual
call to setup_new_exec().

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
