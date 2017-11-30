From: tytso@mit.edu (Theodore Ts'o)
Date: Thu, 30 Nov 2017 09:16:36 -0500
Subject: [kernel-hardening] Re: [PATCH v5 next 5/5] net: modules: use
	request_module_cap() to load 'netdev-%s' modules
In-Reply-To: <CAEiveUdgm_n-TUYGCtw_Zf24TJXrdrsFjcU8_S1M2qQUmHG+KA@mail.gmail.com>
References: <CA+55aFzxFQeyk6Mrk50=jzevHpZ78BXz_9nHcHabMWBdM6RC6A@mail.gmail.com>
	<CA+55aFyybavkF8ccQKJsoVAF+MG=J5=e9PxXKU=J_hqCQRZnug@mail.gmail.com>
	<CAGXu5jLU8LqTYM9SYQADeH9wm2npVu4AEuSqvYqi3S+qtjC-Qw@mail.gmail.com>
	<CA+55aFwDfBnMVGfBVkrFFr26tp1y8CUpSf154AuXH+sWyeY5FA@mail.gmail.com>
	<CAGXu5j+Tv4KHytjOtBvG9e53o-pG7h5DjZZkATXbado-HAbKHw@mail.gmail.com>
	<CA+55aFxiDKfe6VCM+aV2OgnkzMpP+iz+rn2k25_Qa_QLex=pPQ@mail.gmail.com>
	<CAGXu5jJQnokKL2MdbQgOhBJ_RMHVvsw4u27Ds=4Jq3Ys=mjtRg@mail.gmail.com>
	<CA+55aFzi3Qj7zOrriRvrX5F4QDWMhkNQ7Qh-0FSCZsG4qk61zg@mail.gmail.com>
	<1512024677.1374.168.camel@gmail.com>
	<CAEiveUdgm_n-TUYGCtw_Zf24TJXrdrsFjcU8_S1M2qQUmHG+KA@mail.gmail.com>
Message-ID: <20171130141636.k3oqybwosdogzfgg@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Nov 30, 2017 at 09:50:27AM +0100, Djalal Harouni wrote:
> In embedded systems we can't maintain a SELinux policy, distro man
> power hardly manage. We have abstracted seccomp etc, but the kernel
> inherited the difficult multiplex things, plus all other paths that
> trigger this.....

> Yes, but it is hard to maintain a whitelist policy, the code is hardly
> maintained...

So this is the part that scares me to death about IOT, and why I tell
everyone to ***never*** trust an IOT device on their home network, and
***never*** trust it with anything you don't mind splattered all over
the front page of NY Times and RT / Sputnick news.

You're saying that you want to use modules (as opposed to compile
everything tightly down to just what you need for the embedded
system); that the code is "hardly maintained".  And yet we're supposed
to consider it trustworthy?

If that's the case, turning off implicit module loading sounds and
thinking that this will somehow be a magic wand sounds.... crazy.

	      	   		     - Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
