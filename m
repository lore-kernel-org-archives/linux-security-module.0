From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 9 Mar 2018 11:13:50 -0800
Subject: [PATCH] exec: Set file unwritable before LSM check
In-Reply-To: <20180309190736.GA4657@beast>
References: <20180309190736.GA4657@beast>
Message-ID: <CA+55aFwsggrvj1Xbo8-uV-Vgj5Ekt5vDwhGtjEgk9EJNP1a3Tw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 9, 2018 at 11:07 AM, Kees Cook <keescook@chromium.org> wrote:
> The LSM check should happen after the file has been confirmed to be
> unchanging. Without this, we could have a ToCToU issue between the
> LSM verification and the actual contents of the file later.

Can we please not add random crazy six-letter acronyms that nobody
uses outside of a very small community?

The point of a commit message is to *explain*, not confuse.

            Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
