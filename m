From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 2 Jun 2017 12:00:22 -0700
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <CABxV-EX8C175BRvYdKO8BObCQ5V30=ge8rE7SeSOzTrADgxxDg@mail.gmail.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<20170530205002.GA9841@srcf.ucam.org>
	<CANA3KFXUTSe8XyU1S+WgjgCtgKSiENp9EJZEaAc7PkVO_tgKqQ@mail.gmail.com>
	<0e0aa575-263a-893a-7ade-f2dc7ce679c2@schaufler-ca.com>
	<CABxV-EX8C175BRvYdKO8BObCQ5V30=ge8rE7SeSOzTrADgxxDg@mail.gmail.com>
Message-ID: <e26e9aa2-12b2-4aac-092b-747e8be160a3@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/2/2017 10:39 AM, Steve Kemp wrote:
>> Create an security module that looks for the attribute
> For what it is worth I thought this seemed like an interesting project
> for a beginner, so I did just that.  I wrote up the experience here:
>
> https://blog.steve.fi/so_i_accidentally_wrote_a_linux_security_module.html
>
> In short it was a very simple and clean approach, which I think is
> hard to get wrong.  The only part I need to work on some more is the
> difference between `user` and `security` attributes.

A 'user' attribute can be set by the file owner. A 'security'
attribute requires privilege. SELinux and Smack use 'security'
attributes to prevent users from mucking with them. You need
to create module hooks for manipulating them, including

	inode_init_security
	inode_setxattr
	inode_post_setxattr
	inode_removexattr
	inode_getsecurity
	inode_listsecurity
	inode_setsecurity
	d_instantiate



>
> Steve
> --
> https://steve.fi/
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
