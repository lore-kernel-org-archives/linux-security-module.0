From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 11 May 2018 09:39:23 -0700
Subject: [PATCH v5 0/7] proc: modernize proc to support multiple private
	instances
In-Reply-To: <20180511093221.GA902@comp-core-i7-2640m-0182e6>
References: <20180511093221.GA902@comp-core-i7-2640m-0182e6>
Message-ID: <CA+55aFwZK+BMsm19sK-Wmfta6PcdvW6z-ghuKsb4PAwk19nRVg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 11, 2018 at 2:42 AM Alexey Gladkov <gladkov.alexey@gmail.com>
wrote:

> This is RFC v5 to modernize procfs and make it able to support multiple
> private instances per the same pid namespace.

So I have no big objections, but I would *really* like this to go through
Al's vfs tree.

Al? Have you looked at this series?

                  Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
