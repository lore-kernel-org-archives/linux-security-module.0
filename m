From: keescook@chromium.org (Kees Cook)
Date: Mon, 2 Jul 2018 13:46:17 -0700
Subject: [PATCH] security: CONFIG_HARDENED_USERCOPY does not need to
	select BUG
In-Reply-To: <20180702201402.GA16773@whence.com>
References: <1530302661-20953-1-git-send-email-kamal@canonical.com>
	<CAGXu5jKXtq75+HkziTT-8F0VHvvOiRrtfez60h8hKK1GaE64ug@mail.gmail.com>
	<20180702201402.GA16773@whence.com>
Message-ID: <CAGXu5jLKKjf8BOj++4sgayU1N7Q9vMewyJX8o6_JkboPm5qEag@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Kamal,

On Mon, Jul 2, 2018 at 1:14 PM, Kamal Mostafa <kamal@canonical.com> wrote:
> On Fri, Jun 29, 2018 at 01:27:08PM -0700, Kees Cook wrote:
>> Do the lkdtm tests for usercopy correctly halt the kernel thread if
>> CONFIG_BUG is removed?
>
> Yes, they do...

Perfect, thanks for double-checking! I'll apply this to my tree.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
