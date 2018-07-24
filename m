From: jmorris@namei.org (James Morris)
Date: Wed, 25 Jul 2018 04:45:56 +1000 (AEST)
Subject: [GIT PULL]  linux-integrity patches for 4.19
In-Reply-To: <1532430023.4127.10.camel@linux.ibm.com>
References: <1532430023.4127.10.camel@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1807250445390.10717@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 24 Jul 2018, Mimi Zohar wrote:

> Hi James,
> 
> This pull request adds support for EVM signatures based on larger
> digests, contains a new audit record AUDIT_INTEGRITY_POLICY_RULE to
> differentiate the IMA policy rules from the IMA-audit messages,
> addresses two deadlocks due to either loading or searching for crypto
> algorithms, and cleans up the audit messages.
> 
> New to 4.19, but not included in this pull request, is support for a
> build time IMA policy. ?Build time IMA policy rules are automatically
> enabled on boot and persist after loading a custom policy.
> 

Thanks, merge to next-general and next-testing.


-- 
James Morris
<jmorris@namei.org>
