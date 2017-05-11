From: sbuisson.ddn@gmail.com (Sebastien Buisson)
Date: Thu, 11 May 2017 14:59:27 +0200
Subject: [PATCH v2 1/2] selinux: add brief info to policydb
In-Reply-To: <cc4d7595-4bfc-2339-0ac7-b443e65f6fd5@schaufler-ca.com>
References: <1493979053-16691-1-git-send-email-sbuisson@ddn.com>
	<cc4d7595-4bfc-2339-0ac7-b443e65f6fd5@schaufler-ca.com>
Message-ID: <CAPkE-bWHAV=bnj2=PXkW9=5wyzo=7M2rQz06ODyt828yU-BUVQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-05-05 20:33 GMT+02:00 Casey Schaufler <casey@schaufler-ca.com>:
> How do you see policy_brief being used by a modules
> with dynamic policy?

Policy's brief is computed on the binary representation every time the
policy is loaded, and when enforce or checkreqprot are changed. It
should not be a problem with a dynamic policy, unless I am missing
something.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
