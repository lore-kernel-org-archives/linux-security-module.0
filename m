From: jmorris@namei.org (James Morris)
Date: Thu, 27 Apr 2017 11:08:32 +1000 (AEST)
Subject: [PATCH 3/3] selinux: expose policy SHA256 checksum via selinuxfs
In-Reply-To: <1493231502.32540.12.camel@tycho.nsa.gov>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
	<1493218936-18522-3-git-send-email-sbuisson@ddn.com>
	<1493231502.32540.12.camel@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.20.1704271107450.28011@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 26 Apr 2017, Stephen Smalley wrote:

> > +	return simple_read_from_buffer(buf, count, ppos, tmpbuf,
> > length);
> > +}
> 
> Should we also include information about the hash used, in case it
> changes in the future?
> 

Good idea, yes.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
