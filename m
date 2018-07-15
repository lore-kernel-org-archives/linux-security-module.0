From: keescook@chromium.org (Kees Cook)
Date: Sat, 14 Jul 2018 19:24:07 -0700
Subject: [PATCH v6 4/8] firmware: add call to LSM hook before firmware
	sysfs fallback
In-Reply-To: <1531505163-20227-5-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1531505163-20227-5-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CAGXu5j+GTMeX=TNO3mEYivBd1_9MGQBfOivnMYg5+63HboyXMA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Add an LSM hook prior to allowing firmware sysfs fallback loading.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
