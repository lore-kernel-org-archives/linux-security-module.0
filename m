From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Fri, 11 May 2018 20:28:32 +0100
Subject: [PATCH v5 0/7] proc: modernize proc to support multiple private
	instances
In-Reply-To: <CA+55aFwZK+BMsm19sK-Wmfta6PcdvW6z-ghuKsb4PAwk19nRVg@mail.gmail.com>
References: <20180511093221.GA902@comp-core-i7-2640m-0182e6>
	<CA+55aFwZK+BMsm19sK-Wmfta6PcdvW6z-ghuKsb4PAwk19nRVg@mail.gmail.com>
Message-ID: <20180511192831.GC30522@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 11, 2018 at 09:39:23AM -0700, Linus Torvalds wrote:
> On Fri, May 11, 2018 at 2:42 AM Alexey Gladkov <gladkov.alexey@gmail.com>
> wrote:
> 
> > This is RFC v5 to modernize procfs and make it able to support multiple
> > private instances per the same pid namespace.
> 
> So I have no big objections, but I would *really* like this to go through
> Al's vfs tree.
> 
> Al? Have you looked at this series?

Looking through it...
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
