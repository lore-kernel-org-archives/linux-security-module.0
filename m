From: jlee@suse.com (joeyli)
Date: Wed, 25 Oct 2017 15:07:30 +0800
Subject: [PATCH 18/27] bpf: Restrict kernel image access functions when
	the kernel is locked down
In-Reply-To: <21530.1508770380@warthog.procyon.org.uk>
References: <20171020164343.e5mlq7ukskfjmlpp@linux-rasp2>
	<20171020155748.kzrvg6565oxh6gmb@linux-rasp2>
	<20171020024732.GJ3285@linux-l9pv.suse>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842476953.7923.18174368926573855810.stgit@warthog.procyon.org.uk>
	<20171019221829.7m5nczg3ltqmhzom@ast-mbp>
	<2582.1508486928@warthog.procyon.org.uk>
	<19424.1508515402@warthog.procyon.org.uk>
	<21530.1508770380@warthog.procyon.org.uk>
Message-ID: <20171025070730.GH8550@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Oct 23, 2017 at 03:53:00PM +0100, David Howells wrote:
> jlee at suse.com wrote:
> 
> > hm... patch 4 only prevents write_mem() but not read_mem().
> > Or I missed anything?
> 
> Actually, yes, as it happens, patch 11 prevents you from even opening /dev/mem
> and /dev/kmem by locking down open of /dev/port.  So I've moved this bit to
> patch 4, simplified and posted a new variant for patch 4.
>

Thank you for pointing out!

Joey Lee
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
