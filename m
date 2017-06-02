From: steve.backup.kemp@googlemail.com (Steve Kemp)
Date: Fri, 2 Jun 2017 23:28:02 +0300
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <e26e9aa2-12b2-4aac-092b-747e8be160a3@schaufler-ca.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
	<0e0aa575-263a-893a-7ade-f2dc7ce679c2@schaufler-ca.com>
	<CABxV-EX8C175BRvYdKO8BObCQ5V30=ge8rE7SeSOzTrADgxxDg@mail.gmail.com>
	<e26e9aa2-12b2-4aac-092b-747e8be160a3@schaufler-ca.com>
Message-ID: <CABxV-EVd+i7U2ohb4yJGwk6BQ9XOFTO--yS2S_VCGp-oK3GZuQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 2, 2017 at 10:00 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:

> A 'user' attribute can be set by the file owner. A 'security'
> attribute requires privilege. SELinux and Smack use 'security'
> attributes to prevent users from mucking with them. You need
> to create module hooks for manipulating them,

That's nice and clear, I appreciate you explaining it to me.

I'll have a go at updating my toy LSM to do that shortly.  For
reference I placed the patch here, but don't expect to submit it
formally to lkmk as it was more an interesting learning experience:

https://github.com/skx/linux/pull/1

(I did take the time to rename it from steve_lsm.c to whitelist_lsm.c
though, lest I look too vain!)

Steve
-- 
https://steve.fi/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
