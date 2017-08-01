From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 1 Aug 2017 06:46:38 -0700
Subject: [PATCH v4 08/15] commoncap: Move cap_elevated calculation into
	bprm_set_creds
In-Reply-To: <1501545093-56634-9-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-9-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrU-KEhF-OaHGVOu64TNeemP1pT1Y1Deba9TSGOzfOfu3w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 31, 2017 at 4:51 PM, Kees Cook <keescook@chromium.org> wrote:
> Instead of a separate function, open-code the cap_elevated test, which
> lets us entirely remove bprm->cap_effective (to use the local "effective"
> variable instead), and more accurately examine euid/egid changes via the
> existing local "is_setid".
>
> The following LTP tests were run to validate the changes:
>
>         # ./runltp -f syscalls -s cap
>         # ./runltp -f securebits
>         # ./runltp -f cap_bounds
>         # ./runltp -f filecaps
>
> All kernel selftests for capabilities and exec continue to pass as well.
>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: James Morris <james.l.morris@oracle.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
