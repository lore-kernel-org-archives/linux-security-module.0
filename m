From: paul@paul-moore.com (Paul Moore)
Date: Mon, 14 Aug 2017 16:59:55 -0400
Subject: [PATCH 0/4] SELinux: Fine-tuning for some function implementations
In-Reply-To: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
Message-ID: <CAHC9VhQOVyA8bu5qWz7=KtGQ_kEVQmso539-VHpd+gGb7L7rig@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Aug 13, 2017 at 10:43 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 13 Aug 2017 16:25:43 +0200
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (4):
>   Delete eight unnecessary variable assignments
>   Adjust jump targets in ebitmap_read()
>   Delete an unnecessary return statement in ebitmap_destroy()
>   Adjust five checks for null pointers

Hi Markus,

I merged many of your patches in the past because I wanted to help
encourage your involvement, but you will remember I mentioned at the
time that I generally dislike merging these trivial, and often
style-only, patches.  I believe I even pointed you in the direction of
our SELinux kernel issue tracker for a list of areas where you could
help contribute in a meaningful way (link below).  My earlier comments
still apply; if you want to continue to contribute to SELinux in the
kernel, please focus your attention on more meaningful changes.  I am
not going to merge any of these patches.

* https://github.com/SELinuxProject/selinux-kernel/issues

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
