<p align="center">
    <a id="image1" href="#image1"><img alt="talos" src="https://avatars.githubusercontent.com/u/13804887?s=200&v=4" height="100"></a>
    <a id="image2" href="#image2"><img alt="flux" src="https://avatars.githubusercontent.com/u/52158677?s=280&v=4" height="100"></a>
    <a id="image3" href="#image3"><img alt="longhorn" src="https://raw.githubusercontent.com/cncf/artwork/master/projects/longhorn/icon/color/longhorn-icon-color.png" height="100"></a>
    <a id="image5" href="#image5"><img alt="kube-vip" src="https://kube-vip.io/images/kube-vip.png" height="100"></a>
    <a id="image6" href="#image6"><img alt="traefik" src="https://icon.icepanel.io/Technology/svg/Traefik-Proxy.svg" height="100"></a>
    <a id="image7" href="#image7"><img alt="cert-manager" src="https://avatars.githubusercontent.com/u/39950598" height="100"></a>
    <a id="image8" href="#image8"><img alt="renovate" src="https://avatars.githubusercontent.com/u/105765982" height="100"></a>
</p>

<h1 align="center">
  Kubernetes Gitops at Home(lab)
</h1>

This repository contains the configurations for my gitops managed kubernetes cluster. The technology stack is as follows:

- [talos](https://www.talos.dev/) is the kubernetes distribution
- [flux2](https://fluxcd.io/) handles gitops (syncing the repository state to the cluster)
- [longhorn](https://longhorn.io/) for the storage provider
- [kube-vip](https://kube-vip.io/) for the load balancer (running in ARP mode)
- [traefik](https://traefik.io/traefik/) provides the `LoadBalancer` and acts as a reverse proxy
- [cert-manager](https://cert-manager.io/) will use Let's Encrypt to provide certs to traefik for all my services
- [renovate](https://www.mend.io/free-developer-tools/renovate/) keeps an eye on the repo and automatically opens PRs to update helm and image versions
- [sops](https://github.com/mozilla/sops) is used to manage any cluster secrets
