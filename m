From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 15 May 2017 13:48:31 -0700
Subject: [PATCH v4 1/2] selinux: add brief info to policydb
In-Reply-To: <1494872563-12467-1-git-send-email-sbuisson@ddn.com>
References: <1494872563-12467-1-git-send-email-sbuisson@ddn.com>
Message-ID: <20170515204831.GA9744@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> Add security_policy_brief hook to give access to policy brief to
> the rest of the kernel. Lustre client makes use of this information
> to detect changes to the policy, and forward it to Lustre servers.
> Depending on how the policy is enforced on Lustre client side,
> Lustre servers can refuse connection.

NAK for any core kernel hooks for code that is purely in staging.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
