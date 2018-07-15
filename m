From: keescook@chromium.org (Kees Cook)
Date: Sat, 14 Jul 2018 19:27:42 -0700
Subject: [PATCH v6 5/8] ima: based on policy require signed firmware
	(sysfs fallback)
In-Reply-To: <1531505163-20227-6-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1531505163-20227-6-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CAGXu5jKWGONcAfxrU_vk4g=La24NDSzS=scZWxp27xJdO_R0zA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> With an IMA policy requiring signed firmware, this patch prevents
> the sysfs fallback method of loading firmware.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Matthew Garrett <mjg59@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
