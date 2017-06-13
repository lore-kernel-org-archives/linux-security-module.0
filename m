From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Tue, 13 Jun 2017 09:55:30 +0200
Subject: [PATCH 05/11] Creation of "check_vmflags" LSM hook
In-Reply-To: <1dccd8da-c96f-3947-d90f-a3f3d4f389fd@schaufler-ca.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<1497286620-15027-6-git-send-email-s.mesoraca16@gmail.com>
	<1dccd8da-c96f-3947-d90f-a3f3d4f389fd@schaufler-ca.com>
Message-ID: <CAJHCu1LdGEEFkpAZqVYYORfXxTA+VuHUv2Pv+rYMN1Nt4KGVBg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-06-12 23:31 GMT+02:00 Casey Schaufler <casey@schaufler-ca.com>:
> Have the hook return a value and return that rather
> than -EPERM. That way a security module can choose an
> error that it determines is appropriate. It is possible
> that a module might want to deny the access for a reason
> other than lack of privilege.
> [...]
>
> Same here
>
> [...]
>
> And here.

Yes, I think you are right. I'll fix it in the next version.
Thank you very much for taking the time to review my patch.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
