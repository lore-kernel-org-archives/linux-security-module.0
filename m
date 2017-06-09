From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sat, 10 Jun 2017 00:23:37 +0900
Subject: [PATCH v1] shebang: restrict python interactive prompt/interpreter
In-Reply-To: <1497020766.21594.239.camel@linux.vnet.ibm.com>
References: <1497014528.21594.190.camel@linux.vnet.ibm.com>
	<201706092302.HCE57804.OSFJFVtMLOQHFO@I-love.SAKURA.ne.jp>
	<1497020766.21594.239.camel@linux.vnet.ibm.com>
Message-ID: <201706100023.JCC87518.OOVtQFLHFOFSJM@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar wrote:
> > > +		ret = kern_path(p, LOOKUP_FOLLOW, &path);
> > > +		if (!ret) {
> > > +			struct inode *inode = d_backing_inode(path.dentry);
> > > +
> > > +			inode_list[total] = inode->i_ino;
> > > +			pr_info("pathname:%s i_ino: %lu\n",
> > > +				p, inode_list[total]);
> > 
> > Leaking reference to "struct path".
> 
> kern_path() is calling "getname_kernel(name)", but that is later
> freed. I'm not seeing it. What are you referring to?

See tomoyo_realpath_nofollow() for example. Where is path_put()?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
