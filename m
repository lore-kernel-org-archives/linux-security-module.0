From: davem@davemloft.net (David Miller)
Date: Tue, 28 Nov 2017 04:14:26 +0900 (KST)
Subject: [PATCH v5 next 0/5] Improve Module autoloading infrastructure
In-Reply-To: <CA+55aFwFEzEU9ci=mFZprjzrhG0P0XgXgqhBSWSv7vFWEAw6rQ@mail.gmail.com>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<CA+55aFwFEzEU9ci=mFZprjzrhG0P0XgXgqhBSWSv7vFWEAw6rQ@mail.gmail.com>
Message-ID: <20171128.041426.801732093971324601.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Nov 2017 10:41:30 -0800

> What are the real life use-cases for normal users having modules
> auto-load?

User opens SCTP socket, SCTP protocol module loads.

People build test cases via namespaces, and in that namespaces normal
users can setup virtual tunnel devices themselves, and those configure
operations can bring the tunnel module in.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
