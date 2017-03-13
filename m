From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 13 Mar 2017 08:04:09 -0400
Subject: Kernel repository updated to v4.11-rc1  *** reverted ??? ***
In-Reply-To: <alpine.LRH.2.20.1703061115270.31922@namei.org>
References: <alpine.LRH.2.20.1703061115270.31922@namei.org>
Message-ID: <1489406649.28954.143.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-03-06 at 11:18 +1100, James Morris wrote:
> FYI, I've merged security-next with v4.11-rc1 and then merged the 
> following queued patches:
> 
> ca97d939db114c8d1619e10a3b82af8615372dae security: mark LSM hooks as __ro_after_init
> dd0859dccbe291cf8179a96390f5c0e45cb9af1d security: introduce CONFIG_SECURITY_WRITABLE_HOOKS
> 84e6885e9e6a818d1ca1eabb9b720b357ab07a8b selinux: fix kernel BUG on prlimit(..., NULL, NULL)
> 791ec491c372f49cea3ea7a7143454a9023ac9d4 prlimit,security,selinux: add a security hook for prlimit
> 
> Please test!

The current tip of the linux-security #next branch has been reverted to
commit 61841be6358c "tpm: declare tpm2_get_pcr_allocation() as static".
Was this intentional?

I'm seeing ...

$ git status
On branch security-next
Your branch is ahead of 'security/next' by 13176 commits.
  (use "git push" to publish your local commits)
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	ca-cert.pem
	ca-cert.x509

nothing added to commit but untracked files present (use "git add" to
track)]
$ git log --oneline -5
ca97d939db11 security: mark LSM hooks as __ro_after_init
dd0859dccbe2 security: introduce CONFIG_SECURITY_WRITABLE_HOOKS
84e6885e9e6a selinux: fix kernel BUG on prlimit(..., NULL, NULL)
791ec491c372 prlimit,security,selinux: add a security hook for prlimit
c1ae3cfa0e89 Linux 4.11-rc1

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
