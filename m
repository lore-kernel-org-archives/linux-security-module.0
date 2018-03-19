From: jmorris@namei.org (James Morris)
Date: Mon, 19 Mar 2018 15:52:18 +1100 (AEDT)
Subject: [PATCH v2] exec: Set file unwritable before LSM check
In-Reply-To: <20180309193020.GA5149@beast>
References: <20180309193020.GA5149@beast>
Message-ID: <alpine.LRH.2.21.1803191551580.5791@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 9 Mar 2018, Kees Cook wrote:

> The LSM check should happen after the file has been confirmed to be
> unchanging. Without this, we could have a race between the Time of Check
> (the call to security_kernel_read_file() which could read the file and
> make access policy decisions) and the Time of Use (starting with
> kernel_read_file()'s reading of the file contents). In theory, file
> contents could change between the two.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: Clarify the ToC/ToU race (Linus)

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
