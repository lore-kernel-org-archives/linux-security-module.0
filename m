From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 13 Jul 2017 14:51:06 -0500
Subject: [kernel-hardening] [PATCH 00/11] S.A.R.A. a new stacked LSM
In-Reply-To: <1499959179.4220.45.camel@linux.vnet.ibm.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<53a2d710-b0f0-cdf9-e7ad-cd8d03fc835a@digikod.net>
	<CAJHCu1+=uYQ-N7CH4KfmTHrN2hJjwzN0tgg4sWHU0LjVr+uGGA@mail.gmail.com>
	<c19917fa-f62c-b7e0-8cbd-f10a96f686ba@digikod.net>
	<CAJHCu1K1Hg5M2HhJxN_aj2P_S8Pez9+8KL=wHKBgAN0jN1+mLg@mail.gmail.com>
	<69ff2195-d0e1-8a0f-b80e-5d8d55947907@nmatt.com>
	<1499801476.6034.265.camel@linux.vnet.ibm.com>
	<988555a2-bed9-234c-843c-0bb68dc60d3f@nmatt.com>
	<1499959179.4220.45.camel@linux.vnet.ibm.com>
Message-ID: <20170713195106.GD4895@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> On Thu, 2017-07-13 at 08:39 -0400, Matt Brown wrote:
> The question is really from a security perspective which is better?
> ?Obviously, as v2 of the patch set changed from using pathnames to
> inodes, it's pretty clear that I think inodes would be better. ?Kees,
> Serge, Casey any comments?

Yes, inode seems clearly better.  Paths are too easily worked around.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
