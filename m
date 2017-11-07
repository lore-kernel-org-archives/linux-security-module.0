From: dhowells@redhat.com (David Howells)
Date: Tue, 07 Nov 2017 22:56:51 +0000
Subject: [PATCH 02/27] Add a SysRq option to lift kernel lockdown
In-Reply-To: <877ev2rnt1.fsf@linux.vnet.ibm.com>
References: <877ev2rnt1.fsf@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842464774.7923.7951986297563109339.stgit@warthog.procyon.org.uk>
Message-ID: <32418.1510095411@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:

> On non-x86 platforms (tested on powerpc) this fails to build with:
> 
> security/lock_down.c: In function ?lockdown_lift_sysrq?:
> security/lock_down.c:100:40: error: ?LOCKDOWN_LIFT_KEY? undeclared (first use in this function)
>    lockdown_lift_sysrq_op.help_msg[5] = LOCKDOWN_LIFT_KEY;
>                                         ^~~~~~~~~~~~~~~~~
> security/lock_down.c:100:40: note: each undeclared identifier is reported only once for each function it appears in

I've added an arch dependency in the Kconfig file in my local branch.  I'll
try to get it pushed again.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
