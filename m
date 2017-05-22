From: paul@paul-moore.com (Paul Moore)
Date: Mon, 22 May 2017 15:14:02 -0400
Subject: [PATCH v7 0/9] SELinux support for Infiniband RDMA
In-Reply-To: <alpine.LRH.2.20.1705221033550.3502@namei.org>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
	<alpine.LRH.2.20.1705221033550.3502@namei.org>
Message-ID: <CAHC9VhQbLmdzQDyeY=j4M=hw-arSmft68ri08Pu1cxpCaFPGpA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, May 21, 2017 at 8:35 PM, James Morris <jmorris@namei.org> wrote:
> On Fri, 19 May 2017, Dan Jurgens wrote:
>
>> From: Daniel Jurgens <danielj@mellanox.com>
>
> What kind of testing has this code had?  It's relatively complex and as a
> security feature, it especially needs to be well-tested.

Check the relevant threads on the SELinux list as well as Daniel's
response.  Aside from the usual developer unit testing, we've gone
through multiple rounds of reviews and have gotten ACKs from the IB
folks.  Daniel is currently working on adding tests to the
selinux-testsuite (see the SELinux list for the patches) and I merged
this to the selinux/next branch last week so we could get as much
exposure as possible before the next merge window (linux-next has
already caught two things).  I did let Daniel know that inclusion in
the next pull request is contingent on the tests being in place (as
well as the userspace, policy, etc.).

I think we are in a good spot right now with this patchset, especially
considering we are only at -rc2 and still have several weeks before
the next merge window opens.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
