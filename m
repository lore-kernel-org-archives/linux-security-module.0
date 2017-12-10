From: james.l.morris@oracle.com (James Morris)
Date: Mon, 11 Dec 2017 09:21:28 +1100 (AEDT)
Subject: [RFC v2 2/3] LSM: Add statistics about the invocation of dynamic
	hooks
In-Reply-To: <0d030add49ec1dfd2971e955ab7856cc536e37b1.1512704909.git.sargun@netflix.com>
References: <cover.1512704909.git.sargun@netflix.com>
	<0d030add49ec1dfd2971e955ab7856cc536e37b1.1512704909.git.sargun@netflix.com>
Message-ID: <alpine.LFD.2.20.1712110911170.19397@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 8 Dec 2017, Sargun Dhillon wrote:

> The purpose of this is similar to the purpose of something like
> iptables -L -n. With the proliferation of LSMs, it's going to
> be more important to have a way to understand what's going on.

The difference with iptables being that it's an application on top of the 
netfilter hooks, with strongly defined behavioral semantics for matches 
and targets, while their configuration is the security policy.

LSM is more like the raw netfilter layer, and I don't think you can make a 
lot of sense from a list of just which hooks are active.  You need 
semantic knowledge of how those hooks are configured, i.e. security 
policy.

I suggest dropping this part for now at least, and perhaps think about 
building an API on top of this feature with strongly defined semantics 
(e.g. something like iptables on top of netfilter). 


- James
-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
