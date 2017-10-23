From: dhowells@redhat.com (David Howells)
Date: Mon, 23 Oct 2017 15:56:57 +0100
Subject: [PATCH 25/27] Lock down /proc/kcore
In-Reply-To: <alpine.LFD.2.20.1710210609270.22771@t440>
References: <alpine.LFD.2.20.1710210609270.22771@t440>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842482228.7923.9630520914833154257.stgit@warthog.procyon.org.uk>
Message-ID: <22790.1508770617@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris <james.l.morris@oracle.com> wrote:

> I have to wonder, though, after everything is locked down, how easy will 
> it be for new things to slip in which need to be included in the lockdown, 
> but are not.

That's always a possibility, and short of reviewing every change, particularly
in the drivers, I'm not sure how to prevent it.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
