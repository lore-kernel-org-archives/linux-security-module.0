From: dhowells@redhat.com (David Howells)
Date: Fri, 20 Oct 2017 09:08:48 +0100
Subject: [PATCH 18/27] bpf: Restrict kernel image access functions when
	the kernel is locked down
In-Reply-To: <20171020024732.GJ3285@linux-l9pv.suse>
References: <20171020024732.GJ3285@linux-l9pv.suse>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842476953.7923.18174368926573855810.stgit@warthog.procyon.org.uk>
	<20171019221829.7m5nczg3ltqmhzom@ast-mbp>
Message-ID: <2582.1508486928@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Joey,

Should I just lock down sys_bpf() entirely for now?  We can always free it up
somewhat later.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
