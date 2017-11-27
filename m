From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 27 Nov 2017 10:41:30 -0800
Subject: [PATCH v5 next 0/5] Improve Module autoloading infrastructure
In-Reply-To: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
Message-ID: <CA+55aFwFEzEU9ci=mFZprjzrhG0P0XgXgqhBSWSv7vFWEAw6rQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Nov 27, 2017 at 9:18 AM, Djalal Harouni <tixxdz@gmail.com> wrote:
>
> The sysctl flag is available at "/proc/sys/kernel/modules_autoload_mode"
>
> When modules_autoload_mode is set to (0), the default, there are no
> restrictions.

So quick question: do we actually need this?

Yes, it may be the current default, but is it anything that people
actually depend on?

I'd have expected that most module loading comes from system actions
anyway, not normal users.

So I'd like to explore first whether it even makes sense to make a new option.

New options are bad because:

 - opt-in security isn't security at all

 - having to configure things is complex

so we should generally strive to _not_ need new random config options.

What are the real life use-cases for normal users having modules auto-load?

               Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
