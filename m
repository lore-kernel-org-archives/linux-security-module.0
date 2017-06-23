From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 23 Jun 2017 13:39:55 -0500
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <87efuaip08.fsf@xmission.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1498174161.7636.4.camel@HansenPartnership.com>
	<20170622233619.GC2894@mail.hallyn.com>
	<1498176787.7636.11.camel@HansenPartnership.com>
	<87efuaip08.fsf@xmission.com>
Message-ID: <20170623183955.GD21137@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Eric W. Biederman (ebiederm at xmission.com):
> Even with one xattr of any type there is something appealing about
> putting the logic that limits that xattr to a namespace in the name.  As

Exactly.  That's the idea - from Stefan - that I thought was a worthwhile
improvement over my own previous patch, which puts the logic in the value.
Most of the complaints raised so far about this patchset are just as valid (or
invalid) against my previous patch, but I was particularly interested in
thoughts on this approach versus mine.

thanks,
-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
