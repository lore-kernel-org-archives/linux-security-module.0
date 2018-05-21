From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 22 May 2018 01:10:02 +0300
Subject: [PATCH 26/33] apparmor: use match_string() helper
In-Reply-To: <1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
	<1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
Message-ID: <CAHp75VdTq4XZNizUNNN=C1wzbkoGBvv6FVHDgCc-PFh4Q7dM0g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

http://kernsec.org/pipermail/linux-security-module-archi

> Cc: John Johansen <john.johansen@canonical.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module at vger.kernel.org

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
