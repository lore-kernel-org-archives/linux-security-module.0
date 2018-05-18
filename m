From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 18 May 2018 13:55:33 -0400
Subject: [PATCH v2 3/9] security: define security_kernel_read_blob()
	wrapper
In-Reply-To: <alpine.LRH.2.21.1805190303100.26396@namei.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
	<74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
	<87y3ghhbws.fsf@xmission.com>
	<alpine.LRH.2.21.1805190303100.26396@namei.org>
Message-ID: <1526666133.3404.67.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-05-19 at 03:13 +1000, James Morris wrote:
> On Thu, 17 May 2018, Eric W. Biederman wrote:
> 
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > 
> > Nack on this sharing nonsense.  These two interfaces do not share any
> > code in their implementations other than the if statement to distinguish
> > between the two cases.
> 
> Hmm, it's not even doing that.
> 
> There's already an if(!file && read_id == X) { } check and this is another 
> one being added.
> 
> > If we want comprehensible and maintainable code in the security modules
> > we need to split these two pieces of functionality apart.
> 
> All ima_read is doing in both the old and new case is checking if there's 
> no file then if it's a certain operation, returning an error.
> 
> To echo Eric and Casey's suggestions, how about changing the name of the 
> hook to security_kernel_read_data() ?

Thanks, James. ?Somehow I missed this option. ?Renaming the existing
hook, would be the easiest solution. ?Eric, are you in agreement with
James' naming suggestion/solution?

> Then ima_read_file() can be changed to ima_read_data(), and then instead 
> of two if (!file && read_id == X) checks, have:
> 
> 	if (!file) {
> 		switch (read_id) {
> 		}
> 	}
> 
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
