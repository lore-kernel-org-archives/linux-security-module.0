From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 03 Jul 2018 08:35:41 -0400
Subject: [PATCH v5 1/8] security: define new LSM hook named
	security_kernel_load_data
In-Reply-To: <64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1530542283-26145-2-git-send-email-zohar@linux.vnet.ibm.com>
	<64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
Message-ID: <1530621341.3452.5.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-07-02 at 11:45 -0700, J Freyensee wrote:
> 
> On 7/2/18 7:37 AM, Mimi Zohar wrote:
> > Differentiate between the kernel reading a file from the kernel loading
> > data provided by userspace.  This patch defines a new LSM hook named
> > security_kernel_load_data.
> 
> If this patch series is re-done, can we tweak the description here 
> please?? From what I understood of the code in this patch, I'd tweak it as:
> 
> "Differentiate between the kernel reading a file specified by userspace 
> and the kernel loading a block of data provided by userspace.? This 
> patch defines a new LSM hook named security_kernel_load_data()."
> 
>  From the description, I got a tad confused if the the kernel
> reading a file was also provided by userspace (I know it may be 2nd-
> nature to people on this list, I'm still learning this kernel
> module).

Could we replace "a block of data provided by userspace" with just
"data provided by userspace"?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
