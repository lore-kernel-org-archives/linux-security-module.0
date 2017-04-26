From: sbuisson.ddn@gmail.com (Sebastien Buisson)
Date: Wed, 26 Apr 2017 17:57:55 +0200
Subject: [PATCH 1/3] selinux: Implement LSM notification system
In-Reply-To: <DB5PR05MB09975186A082246C7649C94CC4110@DB5PR05MB0997.eurprd05.prod.outlook.com>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
	<8d4c5ab6-8c15-312a-398b-c3ee9d7e8cb6@schaufler-ca.com>
	<DB5PR05MB09975186A082246C7649C94CC4110@DB5PR05MB0997.eurprd05.prod.outlook.com>
Message-ID: <CAPkE-bVuy=-QcFHMZ841ax7rfssPuBLML2aY3Yi6nGOKeCUcQA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-04-26 17:48 GMT+02:00 Daniel Jurgens <danielj@mellanox.com>:
> This was part of a larger patch set that hasn't been accepted yet.  SELinux support for Inifiniband.  Subsequent patches in that patch set will use it as well.

I revived this patch following Stephen Smalley's suggestion to base
the policy checksum computation and change notification on the work
you had done on LSM notification callbacks.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
