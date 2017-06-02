From: steve.backup.kemp@googlemail.com (Steve Kemp)
Date: Fri, 2 Jun 2017 20:39:21 +0300
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <0e0aa575-263a-893a-7ade-f2dc7ce679c2@schaufler-ca.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
	<0e0aa575-263a-893a-7ade-f2dc7ce679c2@schaufler-ca.com>
Message-ID: <CABxV-EX8C175BRvYdKO8BObCQ5V30=ge8rE7SeSOzTrADgxxDg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> Create an security module that looks for the attribute

For what it is worth I thought this seemed like an interesting project
for a beginner, so I did just that.  I wrote up the experience here:

https://blog.steve.fi/so_i_accidentally_wrote_a_linux_security_module.html

In short it was a very simple and clean approach, which I think is
hard to get wrong.  The only part I need to work on some more is the
difference between `user` and `security` attributes.

Steve
--
https://steve.fi/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
