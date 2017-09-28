From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 28 Sep 2017 08:51:30 -0700
Subject: [RFC PATCH 1/3] fs: define new read_iter rwf flag
In-Reply-To: <20170928135416.GA30859@bombadil.infradead.org>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1506602373-4799-2-git-send-email-zohar@linux.vnet.ibm.com>
	<20170928135416.GA30859@bombadil.infradead.org>
Message-ID: <CA+55aFwte=U_YCeV8u+5+7VrJs-mz6ieqM8zu2j7Ox-7+F3C0Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 28, 2017 at 6:54 AM, Matthew Wilcox <willy@infradead.org> wrote:
>
> I don't like adding a bool parameter everywhere.  Why not add a flag
> to the kiocb ki_flags?
>
> #define IOCB_RWSEM_HELD         (1 << 8)

Yeah, I think that would be a nicer approach, with filesystems that
don't care being able to just ignore it entirely.

                     Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
