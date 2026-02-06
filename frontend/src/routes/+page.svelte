<script lang="ts">
	import { onMount } from 'svelte';

	interface Service {
		id: number;
		title: string;
		category: string;
		provider: string;
		rating: number;
		reviews: number;
		price: number;
		description: string;
		image?: string;
		location: string;
		available: boolean;
	}

	let searchQuery = '';
	let selectedCategory = 'all';
	let services: Service[] = [];
	let filteredServices: Service[] = [];

	const categories = [
		{ id: 'all', name: 'Todos'},
		{ id: 'plumbing', name: 'Plomería'},
		{ id: 'electricity', name: 'Electricidad' },
		{ id: 'cleaning', name: 'Limpieza' },
		{ id: 'moving', name: 'Mudanzas' },
		{ id: 'handyman', name: 'Manitas' },
		{ id: 'gardening', name: 'Jardinería' }
	];

	// Datos de ejemplo
	const mockServices: Service[] = [
		{
			id: 1,
			title: 'Reparación de grifos y tuberías',
			category: 'plumbing',
			provider: 'Juan Pérez',
			rating: 4.8,
			reviews: 127,
			price: 45,
			description: 'Especialista en reparación de grifos, tuberías y sistemas de fontanería. Respuesta rápida.',
			location: 'Madrid Centro',
			available: true
		},
		{
			id: 2,
			title: 'Instalación eléctrica completa',
			category: 'electricity',
			provider: 'María García',
			rating: 4.9,
			reviews: 89,
			price: 120,
			description: 'Instalaciones eléctricas seguras y certificadas. Presupuesto sin compromiso.',
			location: 'Barcelona',
			available: true
		},
		{
			id: 3,
			title: 'Limpieza profunda de hogar',
			category: 'cleaning',
			provider: 'Limpiezas Express',
			rating: 4.7,
			reviews: 234,
			price: 60,
			description: 'Limpieza profunda de toda la casa. Productos ecológicos. Personal confiable.',
			location: 'Valencia',
			available: true
		},
		{
			id: 4,
			title: 'Mudanza completa',
			category: 'moving',
			provider: 'Mudanzas Rápidas',
			rating: 4.6,
			reviews: 156,
			price: 250,
			description: 'Servicio completo de mudanza. Empaquetado, transporte y montaje incluido.',
			location: 'Sevilla',
			available: true
		},
		{
			id: 5,
			title: 'Montaje de muebles',
			category: 'handyman',
			provider: 'Carlos Ruiz',
			rating: 4.9,
			reviews: 312,
			price: 35,
			description: 'Montaje profesional de muebles IKEA y otros. Herramientas incluidas.',
			location: 'Madrid',
			available: true
		},
		{
			id: 6,
			title: 'Mantenimiento de jardín',
			category: 'gardening',
			provider: 'Jardines Verdes',
			rating: 4.8,
			reviews: 98,
			price: 50,
			description: 'Corte de césped, poda de árboles y mantenimiento general del jardín.',
			location: 'Málaga',
			available: true
		},
		{
			id: 7,
			title: 'Reparación de electrodomésticos',
			category: 'handyman',
			provider: 'Técnico Express',
			rating: 4.7,
			reviews: 201,
			price: 55,
			description: 'Reparación de lavadoras, frigoríficos y otros electrodomésticos.',
			location: 'Bilbao',
			available: true
		},
		{
			id: 8,
			title: 'Instalación de aire acondicionado',
			category: 'electricity',
			provider: 'Climatización Pro',
			rating: 4.9,
			reviews: 145,
			price: 180,
			description: 'Instalación profesional de sistemas de climatización. Garantía incluida.',
			location: 'Madrid',
			available: true
		}
	];

	onMount(() => {
		services = mockServices;
		filteredServices = services;
	});

	function filterServices() {
		filteredServices = services.filter((service) => {
			const matchesSearch =
				searchQuery === '' ||
				service.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
				service.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
				service.provider.toLowerCase().includes(searchQuery.toLowerCase());

			const matchesCategory =
				selectedCategory === 'all' || service.category === selectedCategory;

			return matchesSearch && matchesCategory && service.available;
		});
	}

	$: {
		filterServices();
	}
</script>

<div class="marketplace">
	<!-- Hero Section con búsqueda -->
	<section class="hero">
		<div class="hero-content">
			<h1>Encuentra el servicio que necesitas</h1>
			<p class="subtitle">Conectamos profesionales con clientes. Servicios de calidad, cuando los necesites.</p>
			
			<div class="search-container">
				<div class="search-box">
					<!-- <span class="search-icon">🔍</span> -->
					<input
						type="text"
						placeholder="¿Qué servicio necesitas? (ej: plomería, electricidad, limpieza...)"
						bind:value={searchQuery}
						class="search-input"
					/>
				</div>
			</div>
		</div>
	</section>

	<!-- Categorías -->
	<section class="categories-section">
		<div class="container">
			<h2>Categorías populares</h2>
			<div class="categories">
				{#each categories as category}
					<button
						class="category-card"
						class:active={selectedCategory === category.id}
						on:click={() => (selectedCategory = category.id)}
					>
						<!-- <span class="category-icon">{category.icon}</span> -->
						<span class="category-name">{category.name}</span>
					</button>
				{/each}
			</div>
		</div>
	</section>

	<!-- Listado de servicios -->
	<section class="services-section">
		<div class="container">
			<div class="section-header">
				<h2>
					{filteredServices.length === 0
						? 'No se encontraron servicios'
						: `${filteredServices.length} servicio${filteredServices.length !== 1 ? 's' : ''} disponible${filteredServices.length !== 1 ? 's' : ''}`}
				</h2>
			</div>

			{#if filteredServices.length > 0}
				<div class="services-grid">
					{#each filteredServices as service}
						<div class="service-card">
							<div class="service-header">
								<div class="service-title-section">
									<h3>{service.title}</h3>
									<p class="service-provider">por {service.provider}</p>
								</div>
								<div class="service-badge">
									<span class="badge-icon">✓</span>
									<span>Disponible</span>
								</div>
							</div>

							<p class="service-description">{service.description}</p>

							<div class="service-footer">
								<div class="service-rating">
									<span class="stars">{'⭐'.repeat(Math.floor(service.rating))}</span>
									<span class="rating-value">{service.rating}</span>
									<span class="reviews-count">({service.reviews})</span>
								</div>
								<div class="service-location">
									<span class="location-icon">📍</span>
									<span>{service.location}</span>
								</div>
							</div>

							<div class="service-price-section">
								<div class="price">
									<span class="price-amount">€{service.price}</span>
									<span class="price-label">/servicio</span>
								</div>
								<button class="btn-contract">Contratar</button>
							</div>
						</div>
					{/each}
				</div>
			{:else}
				<div class="no-results">
					<p>No se encontraron servicios que coincidan con tu búsqueda.</p>
					<button class="btn-clear-filters" on:click={() => {
						searchQuery = '';
						selectedCategory = 'all';
					}}>
						Limpiar filtros
					</button>
				</div>
			{/if}
		</div>
	</section>
</div>

<style>
	.marketplace {
		min-height: 100vh;
		background: linear-gradient(to bottom, #f8fafc 0%, #ffffff 30%);
	}

	/* Hero Section */
	.hero {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		padding: 4rem 2rem;
		text-align: center;
	}

	.hero-content {
		max-width: 800px;
		margin: 0 auto;
	}

	.hero h1 {
		font-size: 3rem;
		font-weight: 700;
		margin-bottom: 1rem;
		color: white;
	}

	.subtitle {
		font-size: 1.25rem;
		margin-bottom: 2.5rem;
		opacity: 0.95;
	}

	.search-container {
		margin-top: 2rem;
	}

	.search-box {
		display: flex;
		align-items: center;
		background: white;
		border-radius: 50px;
		padding: 0.75rem 1.5rem;
		box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
		max-width: 700px;
		margin: 0 auto;
	}

	.search-icon {
		font-size: 1.25rem;
		margin-right: 1rem;
		color: #667eea;
	}

	.search-input {
		flex: 1;
		border: none;
		outline: none;
		font-size: 1rem;
		color: #333;
		background: transparent;
	}

	.search-input::placeholder {
		color: #999;
	}

	/* Categorías */
	.categories-section {
		padding: 3rem 2rem;
		background: white;
	}

	.container {
		max-width: 1200px;
		margin: 0 auto;
	}

	.categories-section h2 {
		font-size: 2rem;
		margin-bottom: 2rem;
		color: #1e293b;
		text-align: center;
	}

	.categories {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
		gap: 1rem;
		margin-bottom: 2rem;
	}

	.category-card {
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 1.5rem 1rem;
		background: #f8fafc;
		border: 2px solid transparent;
		border-radius: 12px;
		cursor: pointer;
		transition: all 0.3s ease;
		font-size: 0.95rem;
	}

	.category-card:hover {
		background: #f1f5f9;
		transform: translateY(-2px);
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	}

	.category-card.active {
		background: #667eea;
		color: white;
		border-color: #667eea;
		box-shadow: 0 4px 16px rgba(102, 126, 234, 0.4);
	}

	.category-icon {
		font-size: 2rem;
		margin-bottom: 0.5rem;
	}

	.category-name {
		font-weight: 600;
	}

	/* Servicios */
	.services-section {
		padding: 3rem 2rem;
		background: #f8fafc;
	}

	.section-header {
		margin-bottom: 2rem;
	}

	.section-header h2 {
		font-size: 1.75rem;
		color: #1e293b;
		font-weight: 600;
	}

	.services-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
		gap: 1.5rem;
	}

	.service-card {
		background: white;
		border-radius: 16px;
		padding: 1.5rem;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
		transition: all 0.3s ease;
		display: flex;
		flex-direction: column;
	}

	.service-card:hover {
		box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
		transform: translateY(-4px);
	}

	.service-header {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		margin-bottom: 1rem;
	}

	.service-title-section h3 {
		font-size: 1.25rem;
		font-weight: 600;
		color: #1e293b;
		margin-bottom: 0.25rem;
		line-height: 1.4;
	}

	.service-provider {
		font-size: 0.875rem;
		color: #64748b;
	}

	.service-badge {
		display: flex;
		align-items: center;
		gap: 0.25rem;
		background: #10b981;
		color: white;
		padding: 0.375rem 0.75rem;
		border-radius: 20px;
		font-size: 0.75rem;
		font-weight: 600;
	}

	.badge-icon {
		font-size: 0.875rem;
	}

	.service-description {
		color: #64748b;
		font-size: 0.95rem;
		line-height: 1.6;
		margin-bottom: 1rem;
		flex: 1;
	}

	.service-footer {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 1rem;
		padding-top: 1rem;
		border-top: 1px solid #e2e8f0;
	}

	.service-rating {
		display: flex;
		align-items: center;
		gap: 0.5rem;
	}

	.stars {
		font-size: 0.875rem;
	}

	.rating-value {
		font-weight: 600;
		color: #1e293b;
		font-size: 0.875rem;
	}

	.reviews-count {
		color: #64748b;
		font-size: 0.875rem;
	}

	.service-location {
		display: flex;
		align-items: center;
		gap: 0.25rem;
		color: #64748b;
		font-size: 0.875rem;
	}

	.location-icon {
		font-size: 0.875rem;
	}

	.service-price-section {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding-top: 1rem;
		border-top: 1px solid #e2e8f0;
	}

	.price {
		display: flex;
		align-items: baseline;
		gap: 0.25rem;
	}

	.price-amount {
		font-size: 1.5rem;
		font-weight: 700;
		color: #667eea;
	}

	.price-label {
		font-size: 0.875rem;
		color: #64748b;
	}

	.btn-contract {
		background: #667eea;
		color: white;
		border: none;
		padding: 0.75rem 1.5rem;
		border-radius: 8px;
		font-weight: 600;
		cursor: pointer;
		transition: all 0.2s ease;
		font-size: 0.95rem;
	}

	.btn-contract:hover {
		background: #5568d3;
		transform: scale(1.05);
	}

	.btn-contract:active {
		transform: scale(0.98);
	}

	.no-results {
		text-align: center;
		padding: 4rem 2rem;
		color: #64748b;
	}

	.no-results p {
		font-size: 1.125rem;
		margin-bottom: 1.5rem;
	}

	.btn-clear-filters {
		background: #667eea;
		color: white;
		border: none;
		padding: 0.75rem 2rem;
		border-radius: 8px;
		font-weight: 600;
		cursor: pointer;
		transition: all 0.2s ease;
	}

	.btn-clear-filters:hover {
		background: #5568d3;
	}

	/* Responsive */
	@media (max-width: 768px) {
		.hero h1 {
			font-size: 2rem;
		}

		.subtitle {
			font-size: 1rem;
		}

		.search-box {
			padding: 0.625rem 1.25rem;
		}

		.search-input {
			font-size: 0.9rem;
		}

		.search-input::placeholder {
			font-size: 0.85rem;
		}

		.categories {
			grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
		}

		.category-card {
			padding: 1rem 0.5rem;
		}

		.category-icon {
			font-size: 1.5rem;
		}

		.services-grid {
			grid-template-columns: 1fr;
		}

		.service-price-section {
			flex-direction: column;
			gap: 1rem;
			align-items: stretch;
		}

		.btn-contract {
			width: 100%;
		}
	}
</style>
