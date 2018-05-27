From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sat, 26 May 2018 18:33:23 -0700
Subject: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
In-Reply-To: <CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
	<CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com>
Message-ID: <CA+55aFx6DBp+d33_fytOGPWw11xg_L0MdGp1M2e5Obc0N9kMRQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, May 26, 2018 at 5:32 PM Kees Cook <keescook@chromium.org> wrote:

> I went through some old threads from 2012 when e268337dfe26 was
> introduced, and later when things got looked at during DirtyCOW. There
> was discussion about removing FOLL_FORCE (in order to block writes on
> a read-only memory region).

Side note, we did that for /dev/mem, and things broke.

Thus commit f511c0b17b08 "Yes, people use FOLL_FORCE ;)"

Side note, that very sam ecommit f511c0b17b08 is also the explanation for
why the patch under discussion now seems broken.

People really do use "write to /proc/self/mem" as a way to keep the
mappings read-only, but have a way to change them when required.

              Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
