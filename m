From: jlee@suse.com (jlee at suse.com)
Date: Sat, 21 Oct 2017 00:43:43 +0800
Subject: [PATCH 18/27] bpf: Restrict kernel image access functions when
	the kernel is locked down
In-Reply-To: <19424.1508515402@warthog.procyon.org.uk>
References: <20171020155748.kzrvg6565oxh6gmb@linux-rasp2>
	<20171020024732.GJ3285@linux-l9pv.suse>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842476953.7923.18174368926573855810.stgit@warthog.procyon.org.uk>
	<20171019221829.7m5nczg3ltqmhzom@ast-mbp>
	<2582.1508486928@warthog.procyon.org.uk>
	<19424.1508515402@warthog.procyon.org.uk>
Message-ID: <20171020164343.e5mlq7ukskfjmlpp@linux-rasp2>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Oct 20, 2017 at 05:03:22PM +0100, David Howells wrote:
> jlee at suse.com wrote:
> 
> > I think that we don't need to lock down sys_bpf() now because
> > we didn't lock down other interfaces for reading arbitrary
> > address like /dev/mem and /dev/kmem.
> 
> Ummm...  See patch 4.  You even gave me a Reviewed-by for it ;-)
> 
> David

hm... patch 4 only prevents write_mem() but not read_mem().
Or I missed anything?

Thanks
Joey Lee
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
