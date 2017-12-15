From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Fri, 15 Dec 2017 11:47:06 +0900
Subject: [question] should 363b02dab09b3 be backported to stable 4.1+?
Message-ID: <20171215024706.GB11199@jagdpanzerIV>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello David, Eric,

please help me out.

I'm looking at 363b02dab09b ("KEYS: Fix race between updating and finding
a negative key") right now. So, I see that it has been backported to stable
4.4+. My question is -- do we have those test_bit(KEY_FLAG_INSTANTIATED)
and test_bit(KEY_FLAG_NEGATIVE) races in stable 4.1?

	-ss
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
