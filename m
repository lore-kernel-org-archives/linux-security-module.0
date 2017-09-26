From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Tue, 26 Sep 2017 16:25:26 +0200
Subject: [RFC v3 0/9] S.A.R.A. a new stacked LSM
In-Reply-To: <1505159427-11747-1-git-send-email-s.mesoraca16@gmail.com>
References: <1505159427-11747-1-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <CAJHCu1JNBOHVUhF8W6iHmQWyRib0eyE3SdbCsrRkNOTf1_XDBQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I've noticed that some of the latest upstream commits broke S.A.R.A.
And now it doesn't compile.
The fix is trivial (just some reordering in a function arguments' list) so
I prefer to not flood the lists with a v4 with just for 2 lines change.
For review and comments the code posted here is still valid.
For those who want to compile S.A.R.A. with the latest upstream changes
there is an always up-to-date patch available here:
https://github.com/smeso/sara/compare/master...sarav3.patch
I'm sorry for the inconvenient.

Salvatore
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
