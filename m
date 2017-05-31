From: me@jessfraz.com (Jessica Frazelle)
Date: Wed, 31 May 2017 16:05:48 +0100
Subject: namespaces todo list?
In-Reply-To: <82271f8b-c366-28b1-90ac-3b0780490fa5@poczta.onet.pl>
References: <82271f8b-c366-28b1-90ac-3b0780490fa5@poczta.onet.pl>
Message-ID: <CAEk6tEwqd5dxMgXSms5g7+hd+8Pufe1+1BKeUQ2Ew9sLBUtbfA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> 3 - keys, keyrings? are they namespace aware or not? I am quite lost in
> that regard, because I happen to hear conflicting statements.

If you are using user namespaces, the keyring is namespaced.



-- 


Jessie Frazelle
4096R / D4C4 DD60 0D66 F65A 8EFC  511E 18F3 685C 0022 BFF3
pgp.mit.edu
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
