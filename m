From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 27 Nov 2017 11:12:59 -0800
Subject: [PATCH v5 next 0/5] Improve Module autoloading infrastructure
In-Reply-To: <CA+55aFwhmgaoHUtCx2=m4SWBtG4dtmY3M8qHLjwe0UaLkBz_eA@mail.gmail.com>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<CA+55aFwFEzEU9ci=mFZprjzrhG0P0XgXgqhBSWSv7vFWEAw6rQ@mail.gmail.com>
	<CA+55aFwhmgaoHUtCx2=m4SWBtG4dtmY3M8qHLjwe0UaLkBz_eA@mail.gmail.com>
Message-ID: <CA+55aFxcte0puN32cV25p8Ex2PKzb3mug-OzpzWWw1EvY35=AA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Nov 27, 2017 at 11:02 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, the above will not necessarily work with a legacy /dev/ directory
> where al the nodes have been pre-populated, and opening the device
> node is supposed to load the module. So _historically_ we did indeed
> load modules as normal users. But does that really happen any more?

Sadly, it looks like bluetoothd actually does expect to load the
bt-proto-XYZ modules with no capabilities at all.

So apparently we really do depend on not needing capabilities for
module loading.

Oh well.

                 Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
