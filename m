From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 15 May 2018 09:41:40 -0500
Subject: [PATCH v2] apparmor: secid: fix error return value in error
	handling path
In-Reply-To: <1f4a965f-a245-a5a9-f815-9915df9b3a9d@canonical.com>
References: <20180504140914.GA16787@embeddedor.com>
	<1f4a965f-a245-a5a9-f815-9915df9b3a9d@canonical.com>
Message-ID: <03eb44c5-ee46-f402-7ae9-5d11a233c1f8@embeddedor.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Colin,


Sorry for the late response. I've been on the road for the last 12 days 
and I'm just back.

On 05/04/2018 09:36 AM, Colin Ian King wrote:
> Hi Gustavo,
> 
> if you are using the coverity scan bug tracking, please can you mark a
> bug as being worked on by yourself so I don't work on it at the same
> time as we're duplicating work here.
> 

Yeah, I've noticed that. I actually do that very often, and in some 
cases I've also noticed you have made changes to the same bug regardless 
of that.

The problem is that the Coverity dashboard doesn't refresh itself, so 
anyone using it should refresh it at all times in order to keep track of 
the bugs that have already been taken by somebody else.

So I think this kind of "collisions" will continue to happen unless 
people add the auto-refresh feature to the Coverity dashboard. :/

Thanks
--
Gustavo
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
